class DateRepair

  def self.repair(event)
    offset = event.start_time.utc_offset
    start_utc = event.start_time - offset
    end_utc = event.end_time - offset
    event.assign_attributes(start_time: start_utc, end_time: end_utc)
    event
  end

  def self.repair_and_save(event)
    self.repair(event).save! if event.valid?
  rescue Exception => e
    puts event.inspect
    raise e
  end

  def self.repair_all
    Event.all.each do |event|
      self.repair_and_save(event)
    end
  end
end
