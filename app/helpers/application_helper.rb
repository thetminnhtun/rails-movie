module ApplicationHelper
    def humanized_duration(minutes)
        hours = minutes / 60
        remaining_minutes = minutes % 60

        formatted_time = ""
        formatted_time += "#{hours}h " if hours.positive?
        formatted_time += "#{remaining_minutes}m" if remaining_minutes.positive?

        formatted_time.strip
    end
end
