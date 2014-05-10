module Ebay

	class Selling
		include HTTParty

		def self.active_auction_count
			summary["ActiveAuctionCount"]
		end
		def self.auction_bid_count
			summary["AuctionBidCount"]
		end
		def self.auction_selling_count
			summary["AuctionSellingCount"]
		end
		def self.total_sold_count
			summary["TotalSoldCount"]
		end
		def self.total_sold_value
			summary["TotalSoldValue"]["__content__"]
		end
		def self.total_auction_selling_value
			summary["TotalAuctionSellingValue"]["__content__"]
		end
		def self.summary
			response["Summary"]
		end
		def self.active_list
			response["ActiveList"]
		end
		def self.bid_list
			response["BidList"]
		end
		def self.sold_list
			response["SoldList"]["OrderTransactionArray"]["OrderTransaction"]
		end
		def self.deleted_from_sold_list
			response["DeletedFromSoldList"]
		end
		def self.deleted_from_unsold_list
			response["DeletedFromUnsoldList"]
		end
		def self.scheduled_list
			response["ScheduledList"]
		end

		class SoldItem < Selling
			attr_reader :line

			def initialize(text)
				@line = text
			end
	
			def item_id
				values["Item"]["ItemID"]
			end
			def current_price
				values["Item"]["SellingStatus"]["CurrentPrice"]["__content__"]
			end 
			def buyer_id
				values["Buyer"]["UserID"]
			end
			def buyer_email
				values["Buyer"]["Email"]
			end
			def dest_zip
				values["Buyer"]["BuyerInfo"]["ShippingAddress"]]["PostalCode"]
			end
			def dest_country
				values["Buyer"]["BuyerInfo"]["ShippingAddress"]["Country"]
			end
			private 
			def values
				@values ||= line["Transaction"]
			end

		end
		def self.unsold_list
			response["UnsoldList"]
		end
		def self.response
			@response = post(Ebay.api_url, :body => request)
			unless @response["GetMyeBaySellingResponse"]["Ack"]=="Success"
				raise "Bad Response #{@response.inspect}"
			else
				@response["GetMyeBaySellingResponse"]
			end
		end
		def self.request(epp="100",pn="1")
			format :xml
			headers(Ebay.ebay_headers.merge({"X-EBAY-API-CALL-NAME" => "GetMyeBaySelling"}))
			@xm = ::Builder::XmlMarkup.new
			@xm.instruct!
			@xm.tag!('GetMyeBaySellingRequest', {"xmlns"=>"urn:ebay:apis:eBLBaseComponents"}) do
				@xm.ActiveList{
					@xm.Include(true)
					@xm.IncludeNotes(false)
					@xm.Pagination{
						@xm.EntriesPerPage(epp)
						@xm.PageNumber(pn)
					}
				}
				@xm.BidList{
					@xm.Include(true)
					@xm.IncludeNotes(false)
					@xm.Pagination{
						@xm.EntriesPerPage(epp)
						@xm.PageNumber(pn)
					}
				}
				@xm.DeletedFromSoldList{
					@xm.Include(true)
					@xm.IncludeNotes(false)
					@xm.Pagination{
						@xm.EntriesPerPage(epp)
						@xm.PageNumber(pn)
					}
				}
				@xm.DeletedFromUnsoldList{
					@xm.Include(true)
					@xm.IncludeNotes(false)
					@xm.Pagination{
						@xm.EntriesPerPage(epp)
						@xm.PageNumber(pn)
					}
				}
				@xm.HideVariations(true)
				@xm.ScheduledList{
					@xm.Include(true)
					@xm.IncludeNotes(false)
					@xm.Pagination{
						@xm.EntriesPerPage(epp)
						@xm.PageNumber(pn)
					}
				}
				@xm.SellingSummary{
					@xm.Include(true)
				}
				@xm.SoldList{
					@xm.Include(true)
					@xm.IncludeNotes(false)
					@xm.Pagination{
						@xm.EntriesPerPage(epp)
						@xm.PageNumber(pn)
					}
				}
				@xm.UnsoldList{
					@xm.Include(true)
					@xm.IncludeNotes(false)
					@xm.Pagination{
						@xm.EntriesPerPage(epp)
						@xm.PageNumber(pn)
					}
				}
				@xm.RequesterCredentials {
					@xm.eBayAuthToken(Ebay.auth_token)
				}
			end
			return @xm.target! 

		end
				
	end
end