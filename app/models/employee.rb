class Employee < ActiveRecord::Base
  # 不同的角色可以对Employee的资源进行不同的操作
  resourcify

  #全局搜索：引入elasticsearch
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  has_many :attendances
  has_one :info, class_name: "EmpBasicInfo", dependent: :destroy
  has_many :attendance_counts
  has_many :annual_holidays

  def self.search(query)
    __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query: query,
            fields: ['sal_number^10', 'name']
          }
        },
        highlight: {
          pre_tags: ['<em class="label label-highlight">'],
          post_tags: ['</em>'],
          fields: {
            sal_number:   { number_of_fragments: 0 },
            name: { fragment_size: 25 }
          }
        }
      }
    )
  end

  def self.import_table(file)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    head_transfer = {"工资号" => "sal_number",
                     "工号" => "job_number",
                     "档案号" => "record_number",
                     "部门" => "workshop",
                     "班组名称" => "group",
                     "班组类别" => "group_category",
                     "姓名" => "name",
                     "性别" => "sex",
                     "出生日期" => "birth_date",
                     "出生年份" => "birth_year",
                     "年龄" => "age",
                     "民族" => "nation",
                     "籍贯" => "native_place",
                     "政治面目" => "political_role",
                     "党团时间" => "political_party_date",
                     "工作时间" => "working_time",
                     "入路时间" => "railway_time",
                     "本单位日期" => "entry_time",
                     "职务" => "duty",
                     "任职时间" => "employment_period",
                     "兼职" => "part_time",
                     "级别" => "grade",
                     "转干时间" => "promotion_leader_time",
                     "技术职务" => "technique_duty",
                     "任技时间" => "hold_technique_time",
                     "工种分类" => "work_type",
                     "班组长类别" => "job_foreman_category",
                     "班组长职务" => "job_foreman_duty",
                     "任班组长" => "job_foreman",
                     "合同岗位" => "contract_station",
                     "三员一长" => "three_one",
                     "人员来源" => "people_source",
                     "人员分类" => "people_category",
                     "文化程度" => "education_background",
                     "毕业时间" => "graduation_time",
                     "毕业学校" => "graduation_school",
                     "学校类别" => "school_sort",
                     "所学专业" => "major",
                     "现在何处" => "where_place",
                     "用工形式" => "employment_form",
                     "合同期限" => "contract_period",
                     "签订时间" => "conclude_contract_time",
                     "档案工资" => "record_saler",
                     "技能工资" => "skilledness_saler",
                     "岗位工资" => "station_saler",
                     "工龄工资" => "seniority_saler",
                     "技能鉴定" => "skilledness_authenticate",
                     "待遇"    => "treatment",
                     "岗位档序" => "station_rank",
                     "技能档序" => "skilledness_rank",
                     "现岗位"   => "station_now",
                     "现岗时间" => "station_now_time",
                     "退休条件" => "retire_condition",
                     "婚况"    => "marriage_status",
                     "分居情况" => "separate_status",
                     "享受探亲" => "visit_family",
                     "户口所在" => "registered_residence",
                     "家庭住址" => "family_address",
                     "备注"    => "comment",
                     "身份证号" => "identity_card_number",
                     "工作证号" => "employee_card_number",
                     "行业代码" => "trade_code",
                     "生产组"  => "produce_group",
                     "工资项目" => "saler_item",
                     "其他工资" => "other_saler",
                     "备用数据" => "comment_data",
                     "TBZ"    => "TBZ",
                     "PY"     => "PY",
                     "单位名称" => "company_name",
                     "CJBZPX" => "CJBZPX",
                     "家属"   => "family",
                     "J01BF" => "J01BF",
                     "职务化" => "duting"
                   }
    header = spreadsheet.row(1).map{ |i| head_transfer[i]}
    (2..spreadsheet.last_row).each do |j|
      row = Hash[[header, spreadsheet.row(j)].transpose]
      employee = find_by(job_number: row["job_number"]) || new
      employee.attributes = row
      employee.save!
      #更新Workshop数据
      if !Workshop.find_by(name: row["workshop"]).present?
        Workshop.create(:name => row["workshop"])
      end
    end


   # 更新Group表数据
    Workshop.all.each do |i|
      Employee.where(:workshop => i.name).pluck(:group).uniq.each do |j|
        if !Group.find_by_name(j).present?
          Group.create(:name => j, :workshop_id => i.id)
        end
      end
    end


  #更新现员表的workshop_id
    Workshop.all.each do |i|
      Employee.all.each do |j|
        if i.name == j.workshop
           j.update(:workshop => i.id)
        end
      end
    end

    # 更新现员表数据
    Employee.all.each do |j|
      j.sal_number = '41' + j.job_number
        j.birth_year = j.birth_date[0..3]
        j.age = Time.now.year - j.birth_year.to_i
        working_years_transfer = (Time.now - j.working_time.to_datetime)/60/60/24/365
        rali_years_transfer = (Time.now - j.railway_time.to_datetime)/60/60/24/365
        j.working_years = working_years_transfer.to_i
        j.rali_years = rali_years_transfer.to_i
        j.save!
    end


   #更新现员表的group_id
    Group.all.each do |i|
      Employee.all.each do |j|
        if i.name == j.group
          j.update(:group => i.id)
        end
      end
    end

    # 更新基本信息表数据
    Employee.all.each do |i|
      EmpBasicInfo.create(:sal_number => i.sal_number,
                          :workshop_id => i.workshop,
                          :group_id => i.group,
                          :name => i.name,
                          :job_number => i.job_number,
                          :sex => i.sex,
                          :identity_card_number => i.identity_card_number,
                          :age => i.age,
                          :duty => i.duty,
                          :employee_id => i.id
                        )
    end


    #更新考勤表信息
    Employee.all.each do |i|
      Attendance.create(:employee_id => i.id, :group_id => i.group, :month => Time.now.month, :year => Time.now.year)
    end

  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |employee|
        csv << employee.attributes.values_at(*column_names)
      end
    end
  end

  scope :search_records, -> (params){self.search(params).records }


end
