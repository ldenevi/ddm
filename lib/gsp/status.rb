module GSP::STATUS
  PENDING   = 'Pending'  # Before expected start date
  ACTIVE    = 'Active'   # After expected start date, not yet completed
  COMPLETED = 'Green'    # Done 
  PAST_DUE  = 'Past Due' # After expected completion date
  
  module TASK
    INACTIVE   = 'Inactive'   # Before targeted start date, but before review is displayed in UI
    ACTIVE     = 'Active'     # After targeted start date, not yet completed
    CONFORMING = 'Conforming' # Completed and conforming to instructions
    NON_CONFORMING = 'Non-Conforming' # Completed and not conforming to instructions
    PAST_DUE   = 'Past Due'   # After expected completion date and not completed (conforming or non-conforming)
  end
end
