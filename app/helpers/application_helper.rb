module ApplicationHelper
  def alert_for(flash_type)
    { success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info' }[flash_type.to_sym] || flash_type.to_s
  end

  def generate_image_tag_for_post(post)
    if post.image.exists?
      image_tag post.image.url(:medium), id: 'image-preview', class: 'img-responsive'
    else
      image_tag 'placeholder.png', id: 'image-preview', class: 'img-responsive'
    end
  end
end
