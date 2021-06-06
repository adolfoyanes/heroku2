class WelcomeController < ApplicationController
	before_action :authenticate_user! , except: [:index, :show]
	def index
		@adelanto_horas = 3
	end
end

