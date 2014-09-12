class Exercise < ActiveRecord::Base
  belongs_to :workout

  def len
    secs = self.dur
    mins = secs/60
    secs = secs%60
    len = ""
    if mins == 1
      len += "1 minute, "
    elsif mins > 1
      len += "#{mins} minutes, "
    end
    len += "#{secs} seconds"
    return len
  end
end
