class Workshop < ApplicationRecord
	has_many :groups
	has_many :attendance_counts
	has_many :employees, class_name: "EmpBasicInfo"
end