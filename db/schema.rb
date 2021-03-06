# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180620062844) do

  create_table "annual_holiday_plans", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "workshop_id"
    t.integer "work_type", comment: "工种"
    t.integer "last_year_people_number", comment: "上年末单位人数"
    t.integer "this_year_people_number", comment: "今年休年休假人数"
    t.integer "five_days", comment: "休5天人数"
    t.integer "ten_days", comment: "休10天人数"
    t.integer "fifteen_days", comment: "休15天人数"
    t.integer "holiday_days", comment: "应休假天数"
    t.integer "January_plan_number", comment: "一月份安排人数"
    t.integer "January_plan_days", comment: "一月份休假天数"
    t.integer "February_plan_number", comment: "二月份安排人数"
    t.integer "February_plan_days", comment: "二月份休假天数"
    t.integer "March_plan_number", comment: "三月份安排人数"
    t.integer "March_plan_days", comment: "三月份休假天数"
    t.integer "April_plan_number", comment: "四月份安排人数"
    t.integer "April_plan_days", comment: "四月份休假天数"
    t.integer "May_plan_number", comment: "五月份安排人数"
    t.integer "May_plan_days", comment: "五月份休假天数"
    t.integer "June_plan_number", comment: "六月份安排人数"
    t.integer "June_plan_days", comment: "六月份休假天数"
    t.integer "July_plan_number", comment: "七月份安排人数"
    t.integer "July_plan_days", comment: "七月份休假天数"
    t.integer "August_plan_number", comment: "八月份安排人数"
    t.integer "August_plan_days", comment: "八月份休假天数"
    t.integer "September_plan_number", comment: "九月份安排人数"
    t.integer "September_plan_days", comment: "九月份休假天数"
    t.integer "October_plan_number", comment: "十月份安排人数"
    t.integer "October_plan_days", comment: "十月份休假天数"
    t.integer "November_plan_number", comment: "十一月份安排人数"
    t.integer "November_plan_days", comment: "十一月份休假天数"
    t.integer "December_plan_number", comment: "十二月份安排人数"
    t.integer "December_plan_days", comment: "十二月份休假天数"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "year"
    t.string "status"
  end

  create_table "annual_holiday_work_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "work_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "annual_holidays", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "employee_id"
    t.integer "holiday_days"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "month"
    t.integer "year"
  end

  create_table "applications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "status", null: false
    t.integer "group_id", null: false
    t.integer "year", null: false
    t.integer "month", null: false
    t.integer "day", null: false
    t.string "employee_id", default: "{}", null: false
    t.string "apply_person", null: false
    t.text "cause", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attendance_counts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "employee_id", null: false
    t.string "vacation_code", null: false
    t.integer "count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "year"
    t.integer "month"
    t.integer "group_id"
    t.integer "workshop_id"
  end

  create_table "attendance_records", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "edit_before", null: false
    t.string "edit_after", null: false
    t.integer "attendance_id", null: false
    t.integer "day", null: false
    t.string "modify_person", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attendance_settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "vacation"
    t.integer "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attendance_statuses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "year"
    t.integer "month"
    t.integer "workshop_id"
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "group_id"
  end

  create_table "attendances", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "month_attendances", default: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "employee_id"
    t.integer "month"
    t.integer "year"
    t.integer "group_id"
  end

  create_table "emp_basic_infos", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "员工基本信息表" do |t|
    t.integer "sal_number", comment: "工资号"
    t.integer "workshop_id"
    t.string "group_id"
    t.string "name", comment: "姓名"
    t.string "job_number", comment: "工号"
    t.integer "sex", limit: 1, default: 1, comment: "性别: 1-男， 2-女"
    t.string "identity_card_number", comment: "身份证号"
    t.integer "age", comment: "年龄"
    t.string "duty", comment: "职务"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "employee_id", null: false
    t.index ["employee_id"], name: "index_emp_basic_infos_on_employee_id", unique: true
  end

  create_table "employees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "sal_number", default: "", collation: "utf8mb4_bin", comment: "工资号"
    t.string "job_number", comment: "工号"
    t.string "record_number", comment: "档案号"
    t.string "workshop"
    t.string "group"
    t.string "name", null: false
    t.string "sex"
    t.string "birth_date"
    t.integer "birth_year"
    t.integer "age"
    t.string "nation", comment: "民族"
    t.string "native_place", comment: "籍贯"
    t.string "political_role", comment: "政治面貌"
    t.string "political_party_date", comment: "党团时间"
    t.string "working_time", comment: "工作时间"
    t.string "railway_time", comment: "入路时间"
    t.string "entry_time", comment: "本单位日期"
    t.string "duty", comment: "职务"
    t.string "employment_period", comment: "任职时间"
    t.string "part_time", comment: "兼职时间"
    t.string "grade", comment: "级别"
    t.string "promotion_leader_time", comment: "转干时间"
    t.string "technique_duty", comment: "技术职务"
    t.string "hold_technique_time", comment: "任技时间"
    t.string "work_type", comment: "工种分类"
    t.string "job_foreman", comment: "任班组长"
    t.string "contract_station", comment: "合同岗位"
    t.string "three_one", comment: "三员一长"
    t.string "people_source", comment: "人员来源"
    t.string "people_category", comment: "人员分类"
    t.string "education_background", comment: "文化程度"
    t.string "graduation_school", comment: "毕业院校"
    t.string "school_sort", comment: "学校类别"
    t.string "major"
    t.string "where_place", comment: "现在何处"
    t.string "employment_form", comment: "用工形式"
    t.string "contract_period", comment: "合同期限"
    t.string "conclude_contract_time", comment: "签订时间"
    t.float "record_saler", limit: 24, comment: "档案工资"
    t.float "skilledness_saler", limit: 24, comment: "技能工资"
    t.float "station_saler", limit: 24, comment: "岗位工资"
    t.float "seniority_saler", limit: 24, comment: "工龄工资"
    t.string "skilledness_authenticate", comment: "技能鉴定"
    t.string "treatment", comment: "待遇"
    t.integer "station_rank", comment: "岗位排序"
    t.integer "skilledness_rank", comment: "技能排序"
    t.string "station_now", comment: "现岗位"
    t.string "station_now_time", comment: "现岗时间"
    t.string "retire_condition", comment: "退休条件"
    t.string "marriage_status", comment: "婚姻情况"
    t.string "separate_status", comment: "分居情况"
    t.string "visit_family", comment: "享受探亲"
    t.string "registered_residence", comment: "户口所在"
    t.string "family_address", comment: "家庭住址"
    t.string "comment", comment: "备注"
    t.string "identity_card_number", comment: "身份证号"
    t.string "employee_card_number", comment: "工作证号"
    t.string "trade_code", comment: "行业代码"
    t.string "produce_group", comment: "生产组"
    t.float "saler_item", limit: 24, comment: "工资项目"
    t.float "other_saler", limit: 24, comment: "其他工资"
    t.float "comment_data", limit: 24, comment: "备用数据"
    t.string "TBZ"
    t.string "PY"
    t.string "company_name", default: "北京供电段", null: false, comment: "单位名称"
    t.string "CJBZPX"
    t.string "family"
    t.integer "J01BF"
    t.string "duting", comment: "职务化"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "graduation_time"
    t.integer "position"
    t.integer "working_years", comment: "工作时长"
    t.integer "rali_years", comment: "入路时长"
    t.string "group_category", comment: "班组类别"
    t.string "job_foreman_category", comment: "班组长类别"
    t.string "job_foreman_duty", comment: "班组长职务"
    t.integer "group_id"
    t.integer "workshop_id"
    t.string "phone_number"
    t.string "avatar"
  end

  create_table "groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "name"
    t.integer "workshop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "holiday_start_times", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "sal_number"
    t.string "name"
    t.string "vacation"
    t.datetime "start_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leaving_employees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "employee_id"
    t.text "cause"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "leaving_type"
    t.integer "transfer_from_workshop"
    t.integer "transfer_from_group"
    t.integer "transfer_to_workshop"
    t.integer "transfer_to_group"
  end

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "message_type"
    t.text "message"
    t.integer "user_id"
    t.boolean "have_read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "remind_time"
  end

  create_table "roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "email", default: "1", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "vacation_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "vacation_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "vacation_shortening", comment: "假期简称"
    t.string "vacation_code", comment: "假期代码"
  end

  create_table "workshops", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
