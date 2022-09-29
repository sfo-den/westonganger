require "test_helper"

class XlsxFreezeTest < ActiveSupport::TestCase

  def base_path
    path = TMP_PATH.join("xlsx/freeze/")
    FileUtils.mkdir_p(path)
    return path
  end

  def setup
    @options = {
      headers: [
        ['Latest Posts'],
        ['Title','Category','Author','Posted on','Posted At','Earnings']
      ],
      data: 50.times.map{|i| [i, "foobar-#{i}", 5.4*i, true, Date.today, Time.now]},
    }
  end

  def teardown
  end

  test "basic" do
    opts = @options.merge({
      freeze: {rows: 1, columns: 1},
    })

    # Using Array Data
    file_data = SpreadsheetArchitect.to_xlsx(opts)

    File.open(base_path.join("freeze_#{__method__}.xlsx"),'w+b') do |f|
      f.write file_data
    end
  end

  test "using_ranges" do
    opts = @options.merge({
      freeze: {rows: (2..4), columns: (2..4)},
    })

    # Using Array Data
    file_data = SpreadsheetArchitect.to_xlsx(opts)

    File.open(base_path.join("freeze_#{__method__}.xlsx"),'w+b') do |f|
      f.write file_data
    end
  end

  test "using_legacy_arguments" do
    opts = @options.merge({
      freeze: {rows: :all, columns: 2},
    })

    # Using Array Data
    file_data = SpreadsheetArchitect.to_xlsx(opts)

    File.open(base_path.join("freeze_#{__method__}.xlsx"),'w+b') do |f|
      f.write file_data
    end
  end

  test "freeze_type" do
    opts = @options.merge({
      freeze: {row: (@options[:data].size-2), column: 16, type: "split_panes"},
    })

    # Using Array Data
    file_data = SpreadsheetArchitect.to_xlsx(opts)

    File.open(base_path.join("freeze_#{__method__}.xlsx"),'w+b') do |f|
      f.write file_data
    end
  end

  test "panes_all_axlsx_options" do
    opts = @options.merge({
      freeze: {
        row: (@options[:data].size-2),
        column: 16, 
        state: "split", 
        #active_pane: "top_right", 
        #top_left_cell: "A2",
      },
    })

    # Using Array Data
    file_data = SpreadsheetArchitect.to_xlsx(opts)

    File.open(base_path.join("freeze_#{__method__}.xlsx"),'w+b') do |f|
      f.write file_data
    end
  end

end