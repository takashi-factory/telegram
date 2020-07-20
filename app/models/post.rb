class Post < ApplicationRecord
  has_one_attached :image
  validates :caption, presence: true
  validate :image_check

  def image_check
    ###### 中身を確認 ######
    if image.present?
      ######## ファイルの種類をチェック ########
      unless image.content_type.in?(%w(image/jpag image/png))
          errors.add(:image, 'にはjpagまたはpngファイルを添付してくだちい')
      end
    else
      unless image.attached?
        errors.add(:image, 'ファイルを添付せい')
      end
    end
  end

end
