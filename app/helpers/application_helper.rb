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

  def profile_avatar_select(user)
    if user.avatar.exists?
      image_tag user.avatar.url(:medium), id: 'image-preview', class: 'img-responsive img-circle profile-image'
    else
      image_tag 'avatar_default.png', id: 'image-preview', class: 'img-responsive img-circle profile-image'
    end
  end
end
