class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks

  validates :title, presence: true, uniqueness: { scope: :user_id }

  accepts_nested_attributes_for :tasks
  validate :task_due_date

  def task_due_date
    due_date_counts = tasks.group_by(&:due_date).map { |key, items| [key, items.count] }
      due_date_counts.each do |a|
        return unless a[1].present?
        if Task.where(due_date: a[0]).count + a[1] >= 3
          return errors.add :due_date, "can not be more than three on same date."
        end
      end
  end
end
