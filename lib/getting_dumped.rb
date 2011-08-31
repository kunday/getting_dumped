require 'rspec'
require 'rspec/core/formatters/base_formatter'
require 'models'

class GettingDumped < RSpec::Core::Formatters::BaseFormatter
  def initialize(options)
    super
    @time = nil
    @start_time = Time.now
    @example_times = []
  end

  def start(count)
    p "Running #{count} examples"
  end

  def example_started(example)
    @time = Time.now
    super
  end
  def example_passed(example)
    super
    @example_times << [example.full_description, Time.now - @time]
  end

  def start_dump
    super
    p "Total Time: #{Time.now - @time}"

    p "Dumping Results. This could take a moment."

    run = Run.new(:run_at => Time.now, :duration => Time.now - @start_time)
    run.save

    @example_times.each do |example|
      Example.new(:name => example[0], :run_time => example[1], :run_id => run.id).save
    end

    p "Dumping complete"
  end
end
