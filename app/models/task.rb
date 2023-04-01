class Task < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :title, presence: true, uniqueness: true

  validate :task_due_date

  def task_due_date
    if Task.where(due_date: due_date).count >= 3
      errors.add :due_date, "can not create more than three on same date"
    end
  end

end


