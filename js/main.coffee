$ ->
  WinningTileValue = 2048
  ppArray = (array) ->
    for row in array
      console.log row

  @board = [0..3].map -> [0..3].map -> 0



  for x in [0..3]
    @board[x] = []
    for y in [0..3]
      @board[x][y] = 0

  randomInt = (x) ->
    Math.floor(Math.random() * x)

  buildBoard = ->
    [0..3].map -> [0..3].map -> 0

  getRandomCell = ->
    [randomInt(4), randomInt(4)]

  randomValue = ->
    values = [2, 2, 2, 4]
    val = values[randomInt(values.length)]

  boardFull = (board) ->
    for x in [0..3]
      for y in [0..3]
        if board[x][y] == 0
          return false
    true

  generateTile = (board) ->
    unless boardFull(board)
      val = randomValue()
      [x, y] = getRandomCell()
      if board[x][y] == 0
        board[x][y] = val
      else
        generateTile(board)

  ppArray(@board)

  getRow = (rowNumber, board) ->
    [r, b] = [rowNumber, board]
    [b[r][0], b[r][1], b[r][2], b[r][3]]

  getColumn = (c, board) ->
    b = board
    [b[0][c], b[1][c], b[2][c], b[3][c]]

  setRow = (newArray, rowNumber, board) ->
    board[rowNumber] = newArray

  setColumn = (newArray, columnNumber, board) ->
    c = columnNumber
    b = board
    [b[0][c], b[1][c], b[2][c], b[3][c]] = newArray
  # setColumn([2,2,2,3], 3, @board)

  arrayEqual = (a, b) ->
    for val, i in a
      if val != b[i]
        return false
    true

  boardEqual = (a, b) ->
    for row, i in a
      unless arrayEqual(row, b[i])
        return false
    true

  moveIsValid = (a, b) ->
    not boardEqual(a,b)

  noValidMoves = (board) ->
    directions = ['up', 'down', 'left', 'right']

    for direction in directions
      newBoard = move(board, direction)
      return false if moveIsValid(newBoard, board)
    true




  mergeCells = (originalCells, direction) ->
    cells = originalCells
    switch direction
      when 'left', 'up'
        for x in [0...3]
          for y in [x+1..3]
            if cells[x] == 0
              break
            else if cells[x] == cells[y]
              cells[x] *= 2
              cells[y] = 0
              break
            else if cells[y] != 0
              break

      when 'right', 'down'
        for x in [3...0]
          for y in [x-1..0]
            if cells[x] == 0
              break
            else if cells[x] == cells[y]
              cells[x] *= 2
              cells[y] = 0
              break
            else if cells[y] != 0
              break
    cells

  collapseCells = (originalCells, direction) ->
    cells = originalCells

    countZero = (array) ->
      count = 0
      for x in array
        if x == 0
          count = count + 1
      count

    count = countZero(originalCells)

    for i in [0...count]
      switch direction
        when 'left', 'up'
          for x in [0...3]
            temp = cells[x]
            if cells[x] == 0
              cells[x] = cells[x+1]
              cells[x+1] = temp

        when 'right', 'down'
          for x in [3...0]
            temp = cells[x]
            if cells[x] == 0
              cells[x] = cells[x-1]
              cells[x-1] = temp
    cells

  gameLost = (board) ->
    boardFull(board) && noValidMoves(board)

  gameWon = (board) ->
    for row in board
      for cell in row
        if cell >= WinningTileValue
          return true
      false


  showBoard = (board) ->
     for x in [0..3]
          for y in [0..3]
            $(".r#{x}.c#{y} ").css("background-color", colorCode(board[x][y]))
            if (board[x][y]) !=0
              $(".r#{x}.c#{y} > div").html(board[x][y])
            else
              $(".r#{x}.c#{y} > div").html('')
  colorCode = (color) ->
    switch color
      when 0 then "#EEEFF2"
      when 0 then "#c3c5c8"
      when 2 then "#0f9dc8"
      when 4 then "#4360c8"
      when 8 then "#5d3bc8"
      when 16 then "#9947c8"
      when 32 then "#AB2E68"
      when 64 then "#c852a3"
      when 128 then "#c84446"
      when 256 then "#c8ac4c"
      when 512 then "#66c82e"
      when 1024 then "#00c83a"
      when 2048 then "#c86306"
      else


  $(".tryAgain").click (e) =>
    @board = buildBoard()
    generateTile(@board)
    generateTile(@board)
    showBoard(@board)





  move = (board, direction) ->

    newBoard = buildBoard()

    for i in [0..3]
      switch direction
        when 'left'
          row = getRow(i, board)
          row = mergeCells(row, 'left')
          row = collapseCells(row, 'left')
          setRow(row, i, newBoard)

        when 'right'
          for i in [0..3]
            row = getRow(i, board)
            row = mergeCells(row, 'right')
            row = collapseCells(row, 'right')
            setRow(row, i, newBoard)

        when 'up'
          for i in [0..3]
            row = getColumn(i, board)
            row = mergeCells(row, 'up')
            row = collapseCells(row, 'up')
            setColumn(row, i, newBoard)

        when 'down'
          for i in [0..3]
            c = getColumn(i, board)
            c = mergeCells(c, 'down')
            c = collapseCells(c, 'down')
            setColumn(c, i, newBoard)
    newBoard

  $('body').keydown (e) =>

    key = e.which
    keys = [37..40]


    if $.inArray(key, keys) > -1
      e.preventDefault()
    else
      return

    direction = switch key
      when 37 then 'left'
      when 38 then 'up'
      when 39 then 'right'
      when 40 then 'down'

    newBoard = move(@board, direction)

    if moveIsValid(newBoard, @board)
      @board = newBoard
      generateTile(@board)
      showBoard(@board)
      if gameLost(@board)
        alert "Game Over"
      else if gameWon(@board)
        alert "Yeah Buddy!"


  @board = buildBoard()
  generateTile(@board)
  generateTile(@board)
  showBoard(@board)



