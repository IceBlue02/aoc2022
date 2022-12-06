import 'dart:io';
 
void main() {
    var contents = File('data.txt').readAsStringSync();
    final parts = contents.split('\n\n');

    List<List<String>> stacks = getInitalStacks(parts[0]);
    stacks = applyInst_part1(stacks, parts[1].trim());
    print(getTopOfStacks(stacks));

    stacks = getInitalStacks(parts[0]);
    stacks = applyInst_part2(stacks, parts[1].trim());
    print(getTopOfStacks(stacks));
}

List<List<String>> getInitalStacks(String input) {
    final lines = input.split('\n');
    lines.removeLast();

    List<List<String>> stacks = List<List<String>>.generate(9, (index) => []);
    int xindx = 0;

    while (1 + 4 * xindx < lines[0].length) {
        for (String line in lines) {
            var char = line[1 + 4 * xindx];
            if (char == ' ') {
                continue;
            } else {
                stacks[xindx].insert(0, char);
            }
        }
        xindx++;        
    }

    return stacks;
}

RegExp instRegExp = new RegExp(r'move (\d+) from (\d) to (\d)');

List<List<String>> move(List<List<String>> stacks, int from, int to) {
    var val = stacks[from-1].removeLast();
    stacks[to-1].add(val);
    return stacks;
}

List<List<String>> applyInst_part1(List<List<String>> stacks, String inst) {
    for (String line in inst.split('\n')) {
        var instdata = instRegExp.allMatches(line).elementAt(0);
        var repeats = int.tryParse(instdata.group(1)!);
        var from = int.tryParse(instdata.group(2)!);
        var to = int.tryParse(instdata.group(3)!);
        for (var i=0; i<repeats!; i++) {
            stacks = move(stacks, from!, to!);
        }
    }

    return stacks;
}

List<List<String>> applyInst_part2(List<List<String>> stacks, String inst) {
    for (String line in inst.split('\n')) {
        var instdata = instRegExp.allMatches(line).elementAt(0);
        var repeats = int.tryParse(instdata.group(1)!);
        var from = int.tryParse(instdata.group(2)!);
        var to = int.tryParse(instdata.group(3)!);
        
        List<String> moving = stacks[from!-1].sublist(stacks[from-1].length - repeats!, stacks[from-1].length);
        stacks[from-1].removeRange(stacks[from-1].length - repeats, stacks[from-1].length);
        stacks[to!-1] = stacks[to-1] + moving;
    }

    return stacks;
}

String getTopOfStacks(List<List<String>> stacks) {
    String output = "";
    for (var s in stacks) {
        output = output + s.last;
    }
    return output;
}