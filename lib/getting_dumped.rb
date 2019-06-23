# frozen_string_literal: true

require 'rspec'
require 'getting_dumped/migrations/create_tables'

class GettingDumped
  RSpec::Core::Formatters.register self, :example_passed, :example_pending, :example_failed

  def initialize(output)
    @output = output
    @run = create_run
    @example_db = DB[:examples]
  end

  def example_pending(example)
    save_example(example)
  end

  def example_passed(example)
    save_example(example)
  end

  def example_failed(example)
    save_example(example)
  end

  private

  attr_reader :run

  def create_run
    run = DB[:runs]
    run.insert(started_at: Time.now)
  end

  def extract_exception(metadata)
    return [nil, nil] if metadata.status != :failed

    exception = metadata[:exception]
    backtrace = exception.backtrace

    [exception, backtrace]
  end

  def write_to_db(metadata, description, exception, backtrace)
    @example_db.insert(
      name: description,
      status: metadata[:status],
      run_id: run,
      run_time: metadata[:run_time],
      started_at: DateTime.parse(metadata[:started_at].to_s),
      finished_at: DateTime.parse(metadata[:finished_at].to_s),
      exception: exception.to_s,
      backtrace: backtrace.to_s
    )
  end

  def save_example(notification)
    metadata = notification.example.execution_result
    exception, backtrace = extract_exception(metadata)
    write_to_db(
      metadata,
      notification.example.full_description,
      exception,
      backtrace
    )
  end
end
