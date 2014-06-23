$ ->

  ppArray = (array) ->
    for row in array
      console.log row

  @board = [0..3].map -> [0..3].map -> 0

  ppArray(@board)

# console.log  "======"


  # array0 = [0..3]
  # array1 = [4..7]
  # array2 = [8..11]
  # array3 = [12..15]

  # grid = [array0, array1, array2, array3]
  # console.log grid


# console.log "======="

  # board = []

  # for x in [0..3]
  #   board[x] = []
  #   for y in [0..3]
  #     board[x][y] = 0
  #     board[x][y]

  # ppArray board


# console.log "======="


generateTyles = (board) ->
