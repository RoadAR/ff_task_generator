# FfTaskGenerator

This is a simple XML task generator for Filter forge 4 CMD renderer, can be used as standalone script or as library

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ff_task_generator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ff_task_generator

## Usage as script
    $ ff_task_generator INPUT_DIR WINE_INPUT_PATH WINE_OUTPUT_PATH TEMPLATE_PATH [-r RANGE]
### Example
    $ ff_task_generator ./input Z:\\input Z:\\output ./tasks.xml.erb -r 0-500


## Usage as lib
```ruby
FfTaskGenerator::InputDirReader.new(path: '/home/user/input', range: 0..500, 
                                    template_path: '/home/user/tasks.xml.erb', 
                                    input_path: 'Z:\\input', output_path: 'Z:\\output').generate_xml!
```
It will return XML as ruby string.
 
## Example template                                   
```xml
<?xml version="1.0" encoding="UTF-8"?>
<Tasks>
	<GlobalSettings>
		<RenderingOptions>
			<UseMultithreading value="true"/>
			<Dither value="true"/>
			<Progressive value="true"/>
			<OptimizeBlurs value="true"/>
			<AntiAliasBitmapComponentSources value="false"/>
			<Jitter value="0"/>
			<TemporaryFilesLocation value=""/>
			<RAMUsageLimit value="90"/>
			<NormalMapFlipY value="false"/>
		</RenderingOptions>
		<BitmapFormatOptions>
			<DefaultFormat value="JPG"/>
			<BMP>
				<BitDepth value="32"/>
				<FlipRowOrder value="false"/>
			</BMP>
			<JPG>
				<Quality value="98"/>
				<FullPrecision value="true"/>
			</JPG>
			<TIF>
				<BitDepth value="8"/>
				<FloatFormat value="false"/>
				<IncludeTransparency value="true"/>
				<ImageCompression value="LZW"/>
			</TIF>
			<TGA>
				<BitDepth value="32"/>
				<IncludeTransparency value="true"/>
				<FlipRowOrder value="false"/>
			</TGA>
			<PNG>
				<BitDepth value="16"/>
				<IncludeTransparency value="true"/>
				<ImageCompression value="BEST"/>
			</PNG>
			<EXR>
				<BitDepth value="32"/>
				<IncludeTransparency value="true"/>
				<ImageCompression value="PIZ"/>
				<FlipRowOrder value="false"/>
			</EXR>
			<PFM/>
		</BitmapFormatOptions>
	</GlobalSettings>

	<% @files.each do |file| %>
	  <Task> 
        <Image value="<%= file.docker_input_path %>" width="32" height="32"/> 
        <Selection value=""/> 
        <Result path="<%= file.docker_output_path %>" format="JPG"/> 
        <Filter value="Z:\input\filter.ffxml"/> 
        <Preset value="<%= file.preset %>"/> 
    </Task>
	<% end %>
     
	</Tasks>
```