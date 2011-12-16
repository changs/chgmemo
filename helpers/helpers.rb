helpers do

  def how_many_to_review
    return current_user.items.all(:review_at.lt => Time.now).count
  end

  def show_flash
    if flash[:notice]
      o = "<div class='alert-message #{flash[:notice_type]} fade in' data-alert='alert' >\n"
      o += "<a class='close' href='#'>&times;</a>"
      o += "<p>#{flash[:notice]}</p>"
      o += "</div>"
      o
    end
  end

  def current_user=(user)
    if user.nil?
      cookies[:auth_token] = nil
    else
      cookies[:auth_token] = user.auth_token
    end
  end

  def current_user
    if cookies[:auth_token]
      @current_user ||= User.first(auth_token: cookies[:auth_token])
    end
  end

  def sign_in(user)
    #TODO Add expires date
    cookies[:auth_token] = user.auth_token
  end

  def logged_in?
    !current_user.nil?
  end

  def authorized? 
    redirect '/login' unless logged_in?
  end

  def partial(template,locals=nil)
    if template.is_a?(String) || template.is_a?(Symbol)
      template=('_' + template.to_s).to_sym
    else
      locals=template
      template=template.is_a?(Array) ? ('_' + template.first.class.to_s.downcase).to_sym : ('_' + template.class.to_s.downcase).to_sym
    end
    if locals.is_a?(Hash)
      haml(template,{:layout => false},locals)      
    elsif locals
      locals=[locals] unless locals.respond_to?(:inject)
      locals.inject([]) do |output,element|
        output <<     haml(template,{:layout=>false},{template.to_s.delete("_").to_sym => element})
      end.join("\n")
    else 
      haml(template,{:layout => false})
    end
  end

  def admin!
    unless current_user.admin
      throw(:halt, [401, "Not authorized\n"])
    end
  end

  def items_added(user)
    now = DateTime.now
    i = 0
    result = Array.new
    while now.yday > 1 
      result[i] = user.items.all(:created_at.gt => (now-7), :created_at.lt => now).count 
      now -= 7
      i += 1
    end
    return result
  end

  def items_remembered(user)
    user.items.all(:interval.gt => 15).count
  end

  include Rack::Utils
  alias_method :h, :escape_html
end
