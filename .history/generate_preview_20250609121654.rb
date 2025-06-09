#!/usr/bin/env ruby

require 'fileutils'

def read_markdown
  File.read('index.md')
end

def convert_to_html(markdown_content)
  html = markdown_content.dup
  
  # Remove YAML front matter
  html.gsub!(/^---.*?---\n/m, '')
  
  # Convert headers (only if not inside HTML tags)
  html.gsub!(/^# (.+)$/) { |match| match.include?('<') ? match : "<h1>#{$1}</h1>" }
  html.gsub!(/^## (.+)$/) { |match| match.include?('<') ? match : "<h2>#{$1}</h2>" }
  html.gsub!(/^### (.+)$/) { |match| match.include?('<') ? match : "<h3>#{$1}</h3>" }
  
  # Convert bold
  html.gsub!(/\*\*(.+?)\*\*/, '<strong>\1</strong>')
  
  # Convert italic (but not inside HTML)
  html.gsub!(/(?<!<[^>]*)\*([^*]+?)\*(?![^<]*>)/, '<em>\1</em>')
  
  # Convert bullet points
  lines = html.split("\n")
  in_list = false
  processed_lines = []
  
  lines.each do |line|
    if line.match(/^- (.+)$/)
      if !in_list
        processed_lines << '<ul>'
        in_list = true
      end
      processed_lines << "<li>#{$1}</li>"
    else
      if in_list
        processed_lines << '</ul>'
        in_list = false
      end
      processed_lines << line
    end
  end
  
  if in_list
    processed_lines << '</ul>'
  end
  
  html = processed_lines.join("\n")
  
  # Convert paragraphs (but preserve HTML blocks)
  lines = html.split("\n")
  result_lines = []
  in_html_block = false
  
  lines.each do |line|
    line_stripped = line.strip
    
    # Check if we're entering/exiting HTML block
    if line_stripped.match(/^<(table|div|ul|ol|blockquote|pre|hr)/)
      in_html_block = true
      result_lines << line
    elsif line_stripped.match(/^<\/(table|div|ul|ol|blockquote|pre)>/)
      in_html_block = false
      result_lines << line
    elsif line_stripped == '<hr>' || line_stripped.match(/^<hr\s*\/?>$/)
      result_lines << line
    elsif in_html_block
      result_lines << line
    elsif line_stripped.empty?
      result_lines << line
    elsif line_stripped.match(/^<h[1-6]>/) || line_stripped.match(/^<\/h[1-6]>/)
      result_lines << line
    else
      # Only wrap in <p> if it's not already HTML and not empty
      if !line_stripped.start_with?('<') && !line_stripped.empty?
        result_lines << "<p>#{line}</p>"
      else
        result_lines << line
      end
    end
  end
  
  result_lines.join("\n")
end

def generate_full_html(content)
  <<~HTML
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Experiment Results</title>
        <style>
            body {
                font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif;
                line-height: 1.6;
                max-width: 980px;
                margin: 0 auto;
                padding: 20px;
                color: #333;
            }
            table {
                border-collapse: collapse;
                width: 100%;
                margin: 20px 0;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 12px;
                text-align: left;
            }
            th {
                background-color: #f2f2f2;
                font-weight: bold;
            }
            h1, h2, h3 {
                color: #333;
            }
            a {
                color: #0366d6;
                text-decoration: none;
            }
            a:hover {
                text-decoration: underline;
            }
            hr {
                border: none;
                border-top: 1px solid #e1e4e8;
                margin: 30px 0;
            }
            ul {
                margin: 10px 0;
                padding-left: 20px;
            }
        </style>
    </head>
    <body>
        #{content}
    </body>
    </html>
  HTML
end

def update_preview
  puts "Updating preview..."
  markdown_content = read_markdown
  html_content = convert_to_html(markdown_content)
  full_html = generate_full_html(html_content)
  
  File.write('preview.html', full_html)
  puts "Preview updated at #{Time.now}"
end

# Initial generation
update_preview

# Watch for changes
puts "Watching index.md for changes... (Press Ctrl+C to stop)"

last_modified = File.mtime('index.md')

loop do
  sleep 1
  current_modified = File.mtime('index.md')
  
  if current_modified > last_modified
    update_preview
    last_modified = current_modified
  end
end 