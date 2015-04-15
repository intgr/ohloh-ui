class Analysis::Chart
  Y_AXIS_TICKS = [1, 3, 5, 10]

  delegate :min_month, :logged_at, :created_at, to: :@analysis

  def data
    series_data_map.each_with_index do |data, index|
      @defaults['series'][index].merge!({ 'data' => data })
    end
    @defaults.merge! range_selector(series.first['ticks'])
  end

  private

  def min_month_as_ticks
    min_month.to_time(:utc).to_i * 1000
  end

  def range_selector(first_ticks)
    buttons = first_ticks.present? ? y_axis_ticks(first_ticks) : []
    buttons.push({ type: 'all', text: 'All' })
    { 'rangeSelector' => { 'inputEnabled' => false, 'buttons' => buttons, 'selected' => (buttons.size - 1) } }
  end

  def latest_date
    @latest_date ||= (logged_at || created_at).at_beginning_of_month
  end

  def y_axis_ticks
    Y_AXIS_TICKS.each_with_object([]) do |array, y_axis|
      array.push({ type: 'year', count: y, text: "#{y_axis}yr" }) if first_ticks < y_axis.years.ago.to_i * 1000
    end
  end

  def series
    months_to_ticks.drop_while { |x| x['ticks'] < min_month_as_ticks }
  end

  def months_to_ticks
    @history.each { |x| x['ticks'] = Time.parse(x['month'] + ' UTC').to_i * 1000 }
  end
end
