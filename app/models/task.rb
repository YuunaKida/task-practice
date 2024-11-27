class Task < ApplicationRecord
    validates :title, presence: true, length: { maximum: 20 }
    validates :explanation, presence: true, length: { maximum: 100 }
    
    validate :due_date_check

    private
    
    def due_date_check
        if due_date.present? && due_date < Date.today
          errors.add(:due_date, "は現在の日付以降でなければなりません")
        end
    end
end
