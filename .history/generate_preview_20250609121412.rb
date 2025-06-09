#!/usr/bin/env ruby

require 'fileutils'

def read_markdown
  File.read('index.md')
end

def convert_to_html(markdown_content)
  html = markdown_content.dup
  
  # Remove YAML front matter
  html.gsub!(/^---.*?---\n/m, '')
  
  # Convert headers
  html.gsub!(/^# (.+)$/, '<h1>\1</h1>')
  html.gsub!(/^## (.+)$/, '<h2>\1</h2>')
  html.gsub!(/^### (.+)$/, '<h3>\1</h3>')
  
  # Convert bold
  html.gsub!(/\*\*(.+?)\*\*/, '<strong>\1</strong>')
  
  # Convert italic
  html.gsub!(/\*(.+?)\*/, '<em>\1</em>')
  
  # Convert bullet points
  html.gsub!(/^- (.+)$/, '<li>\1</li>')
  html.gsub!(/<li>.*<\/li>/m) { |match| "<ul>#{match}</ul>" }
  
  # Convert line breaks
  html.gsub!(/\n\n/, '</p><p>')
  html.gsub!(/^(?!<)(.+)$/) { |line| "<p>#{line}</p>" unless line.strip.empty? || line.start_with?('<') }
  
  # Clean up
  html.gsub!(/<p><\/p>/, '')
  html.gsub!(/<p>(<h\d>.*?<\/h\d>)<\/p>/, '\1')
  html.gsub!(/<p>(<ul>.*?<\/ul>)<\/p>/m, '\1')
  html.gsub!(/<p>(<table>.*?<\/table>)<\/p>/m, '\1')
  html.gsub!(/<p>(<div.*?<\/div>)<\/p>/m, '\1')
  html.gsub!(/<p>(<hr>)<\/p>/, '\1')
  
  html
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