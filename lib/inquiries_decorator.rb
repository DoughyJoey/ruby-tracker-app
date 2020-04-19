# the concret component we would like to decorate, a message in our example
class BasicInquiry
	def initialize(message)
		@text = message
		@description = "Message Details: "
	end
	
	
	def details
		return @description + @text + ". "
	end	
end

# decorator class -- this serves as the superclass for all the concrete decorators
# the base/super class decorator (i.e. no actual decoration yet), each concrete decorator (i.e. subclass) will add its own decoration
class InquiryDecorator
	def initialize(real_inquiry)
		@real_inquiry = real_inquiry
		@feature = "no extra inquiry"
	end
	
	# override the details method to include the description of the extra feature
	def details
		return @feature + ". " + @real_inquiry.details
	end
	
end


# a concrete decorator
class StockDecorator < InquiryDecorator
	def initialize(real_inquiry)
		super(real_inquiry)
		@feature = "stock"
	end
	
	# override the details method to include the description of the extra feature
	def details
		return "Topic: " + @feature + ". " + @real_inquiry.details
	end	
end

# another concrete decorator
class CryptoDecorator < InquiryDecorator
	def initialize(real_inquiry)
		super(real_inquiry)
		@feature = "crypto"
	end
	
	# override the details method to include the description of the extra feature
	def details
		return "Topic: " + @feature + ". " + @real_inquiry.details  
	end	
end

# another concrete decorator
class OtherDecorator < InquiryDecorator
	def initialize(real_inquiry)
		super(real_inquiry)
		@feature = "other"
	end
	
	# override the details method to include the description of the extra feature
	def details
		return "Topic: " + @feature + ". " + @real_inquiry.details  
	end	
end


