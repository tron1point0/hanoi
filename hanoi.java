import java.util.List;
import java.util.LinkedList;

public class hanoi {
    public static List<Move> solve(int n, String a, String b, String c) {
        List<Move> moves = new LinkedList<Move>();
        if(n == 0) return moves;
        moves.addAll(solve(n-1,a,c,b));
        moves.add(new Move(a,c));
        moves.addAll(solve(n-1,b,a,c));
        return moves;
    }
    public static void main(String[] args) {
        int n = 7;
        if (args.length > 0) n = Integer.parseInt(args[0]);
        System.out.println(n);
        for(Move m : solve(n,"A","B","C")) System.out.println(m);
    }
}

class Move {
    String from;
    String to;
    public Move(String from, String to) {
        this.from = from;
        this.to = to;
    }
    public String toString() {
        return from + " -> " + to;
    }
}
