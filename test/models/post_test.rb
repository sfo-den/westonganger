require "test_helper"

class PostTest < ActiveSupport::TestCase

  def setup
    @path = Rails.root.join('tmp/posts')
    FileUtils.mkdir_p(@path)

    @headers = ['test1', 'test2','test3']
    @data = [
      ['row1','test1'],
      ['row2 c1', nil, '123'],
      ['the',Date.today,Time.now]
    ]
    @options = {
      headers: true,
      header_style: {background_color: 'AAAAAA', color: 'FFFFFF', align: :center, font_name: 'Arial', font_size: 10, bold: false, italic: false, underline: false},
      row_style: {background_color: nil, color: '000000', align: :left, font_name: 'Arial', font_size: 10, bold: false, italic: false, underline: false},
      sheet_name: 'My Project Export',
      column_styles: [],
      range_styles: [],
      merges: [],
      borders: [],
      column_types: [:string, :date, :date]
    }
  end

  def teardown
  end

  def test_csv_options
    File.open(File.join(@path, 'options.csv'),'w+b') do |f|
      f.write Post.to_csv(@options)
    end
  end

end
