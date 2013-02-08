module GSP::STATUS
  PENDING   = 'Pending'  # Before expected start date
  ACTIVE    = 'Active'   # After expected start date, not yet completed
  COMPLETED = 'Green'    # Done 
  PAST_DUE  = 'Past Due' # After expected completion date
end
