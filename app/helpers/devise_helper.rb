module DeviseHelper
  def devise_error_messages!

    flash_alerts = []

    if !flash.empty?
      flash_alerts.push(flash[:error]) if flash[:error]
      flash_alerts.push(flash[:alert]) if flash[:alert]
      flash_alerts.push(flash[:notice]) if flash[:notice]
    end

    return '' if resource.errors.empty?  && flash_alerts.empty?
    errors = resource.errors.empty? ? flash_alerts : resource.errors.full_messages
    #messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    messages = errors.map { |msg| content_tag(:li, " #{msg}") }.join
    html = <<-HTML
    <div class="alert alert-danger"> <button type="button"
    class="close" data-dismiss="alert">x</button>
      #{messages}
    </div>
    HTML

    html.html_safe
  end
end