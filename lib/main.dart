import 'package:flutter/material.dart';
import 'pair.dart';

void main() {
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
          primarySwatch: Colors.yellow, primaryTextTheme: const TextTheme(titleLarge: TextStyle(color: Colors.black))),
      home: const TicTacToeMap(title: 'tic-tac-toe'),
    );
  }
}

class TicTacToeMap extends StatefulWidget {
  const TicTacToeMap({super.key, required this.title});
  final String title;

  @override
  State<TicTacToeMap> createState() => _TicTacToeMapState();
}

class _TicTacToeMapState extends State<TicTacToeMap> {
  List<List<Color>> _colorMatrix = List<List<Color>>.generate(3, (_) => List<Color>.filled(3, Colors.white));
  bool _firstPlayerTurn = true;
  bool _playAgain = false;
  bool _gameActive = true;

  void _setColor(int lineIndex, int columnIndex) {
    setState(() {
      if (_colorMatrix[lineIndex][columnIndex] == Colors.white && _gameActive) {
        if (_firstPlayerTurn) {
          _colorMatrix[lineIndex][columnIndex] = Colors.red;
          _checkGameState(Colors.red);
        } else {
          _colorMatrix[lineIndex][columnIndex] = Colors.green;
          _checkGameState(Colors.green);
        }
        _firstPlayerTurn = !_firstPlayerTurn;
      }
    });
  }

  void _checkGameState(final Color playerColor) {
    List<Pair<int, int>> result = _checkRows(playerColor);
    if (result.isNotEmpty) {
      _showWinner(result, playerColor);
      return;
    }

    result = _checkColumns(playerColor);
    if (result.isNotEmpty) {
      _showWinner(result, playerColor);
      return;
    }

    result = _checkDiagonals(playerColor);
    if (result.isNotEmpty) {
      _showWinner(result, playerColor);
      return;
    }
    _checkAvailableMoves();
  }

  List<Pair<int, int>> _checkRows(final Color playerColor) {
    final List<Pair<int, int>> winningCombination = <Pair<int, int>>[];

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (_colorMatrix[i][j] != playerColor) {
          winningCombination.clear();
          break;
        } else {
          winningCombination.add(Pair<int, int>(i, j));
        }
      }
      if (winningCombination.isNotEmpty) {
        return winningCombination;
      }
    }
    return winningCombination;
  }

  List<Pair<int, int>> _checkColumns(final Color playerColor) {
    final List<Pair<int, int>> winningCombination = <Pair<int, int>>[];

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (_colorMatrix[j][i] != playerColor) {
          winningCombination.clear();
          break;
        } else {
          winningCombination.add(Pair<int, int>(j, i));
        }
      }
      if (winningCombination.isNotEmpty) {
        return winningCombination;
      }
    }
    return winningCombination;
  }

  List<Pair<int, int>> _checkDiagonals(final Color playerColor) {
    final List<Pair<int, int>> winningCombination = <Pair<int, int>>[];

    for (int i = 0; i < 3; i++) {
      if (_colorMatrix[i][i] != playerColor) {
        winningCombination.clear();
        break;
      } else {
        winningCombination.add(Pair<int, int>(i, i));
      }
    }
    if (winningCombination.isNotEmpty) {
      return winningCombination;
    }

    for (int i = 0; i < 3; i++) {
      if (_colorMatrix[i][2 - i] != playerColor) {
        winningCombination.clear();
        break;
      } else {
        winningCombination.add(Pair<int, int>(i, 2 - i));
      }
    }
    return winningCombination;
  }

  void _checkAvailableMoves() {
    bool availableSlots = false;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (_colorMatrix[i][j] == Colors.white) {
          availableSlots = true;
        }
      }
    }
    if (!availableSlots) {
      _endGame();
    }
  }

  void _showWinner(final List<Pair<int, int>> winningCombination, Color playerColor) {
    _colorMatrix = List<List<Color>>.generate(3, (_) => List<Color>.filled(3, Colors.white));
    for (final Pair<int, int> pair in winningCombination) {
      _colorMatrix[pair.first][pair.second] = playerColor;
    }
    _endGame();
  }

  void _endGame() {
    setState(() {
      _gameActive = false;
      _playAgain = true;
    });
  }

  void _reset() {
    setState(() {
      _colorMatrix = List<List<Color>>.generate(3, (_) => List<Color>.filled(3, Colors.white));
      _firstPlayerTurn = true;
      _playAgain = false;
      _gameActive = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        _setColor(0, 0);
                      },
                      child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            color: _colorMatrix[0][0],
                          ))),
                  GestureDetector(
                      onTap: () {
                        _setColor(0, 1);
                      },
                      child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(border: Border.all(), color: _colorMatrix[0][1]))),
                  GestureDetector(
                      onTap: () {
                        _setColor(0, 2);
                      },
                      child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(border: Border.all(), color: _colorMatrix[0][2])))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        _setColor(1, 0);
                      },
                      child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(border: Border.all(), color: _colorMatrix[1][0]))),
                  GestureDetector(
                      onTap: () {
                        _setColor(1, 1);
                      },
                      child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(border: Border.all(), color: _colorMatrix[1][1]))),
                  GestureDetector(
                      onTap: () {
                        _setColor(1, 2);
                      },
                      child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(border: Border.all(), color: _colorMatrix[1][2])))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        _setColor(2, 0);
                      },
                      child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(border: Border.all(), color: _colorMatrix[2][0]))),
                  GestureDetector(
                      onTap: () {
                        _setColor(2, 1);
                      },
                      child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(border: Border.all(), color: _colorMatrix[2][1]))),
                  GestureDetector(
                      onTap: () {
                        _setColor(2, 2);
                      },
                      child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(border: Border.all(), color: _colorMatrix[2][2])))
                ],
              ),
              Visibility(visible: _playAgain, child: TextButton(onPressed: _reset, child: const Text('PLAY AGAIN')))
            ],
          ),
        ));
  }
}
