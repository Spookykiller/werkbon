module ApplicationHelper
        
    def custom_bootstrap_flash
      flash_messages = []
      flash.each do |type, message|
        type = 'success' if type == 'notice'
        type = 'error'   if type == 'alert'
        text = "<script>toastr.#{type}('#{message}');</script>"
        flash_messages << text.html_safe if message
      end
      flash_messages.join("\n").html_safe
    end
    
    def rounding(number)
      number_with_precision(number, precision: 2, separator: ",", delimiter: ".")
    end
end
