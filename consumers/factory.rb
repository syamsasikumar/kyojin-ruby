class ConsumerFactory
    def get_feed(type)
        case type
        when 'bbc'
            return BBC.new
        when 'sky'
            return Sky.new
        when 'dm'
            return DM.new
        when 'times'
            return Times.new
        when 'guardian'
            return Guardian.new
        else
            return false
        end
    end
end
