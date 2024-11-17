module Games
  class Index < BaseOperation
    DEFAULT_PAGE = 1
    DEFAULT_PER_PAGE = 10
    def initialize(filter_params:, page: DEFAULT_PAGE)
      @scope = Game.all
      @filter_params = filter_params
      @page = page
    end

    def call
      by_name
      by_status

      @scope = @scope.order(created_at: :desc).page(@page).per(DEFAULT_PER_PAGE)
      @scope
    end

    def by_name
      return if @filter_params[:name].blank?

      @scope = @scope.where('name ILIKE ?', "%#{@filter_params[:name]}%")
    end

    def by_status
      return if @filter_params[:status].blank?

      @scope = @scope.where(status: @filter_params[:status])
    end
  end
end
