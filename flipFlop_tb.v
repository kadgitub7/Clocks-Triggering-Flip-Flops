`timescale 1ns / 1ps

module flipFlop_tb();
    reg Clk;
    reg S;
    reg R;
    wire Q;
    wire Qnot;

    flipFlop uut (
        .Clk(Clk),
        .S(S),
        .R(R),
        .Q(Q),
        .Qnot(Qnot)
    );

    initial begin
        Clk = 0;
        S = 0;
        R = 0;

        #10;

        S = 1; R = 0; #10;
        S = 0; R = 1; #10;

        Clk = 1; S = 1; R = 0; #10;

        S = 0; R = 0; #10;
        
        S = 0; R = 1; #10;

        S = 0; R = 0; #10;
        
        Clk = 0; S = 1; R = 0; #10;
        
        Clk = 1; #10;
        
        S = 1; R = 1; #10;

        S = 0; R = 0; Clk = 0; #10;

        $display("Simulation complete.");
        $finish;
    end

    initial begin
        $monitor("Time=%0t | Clk=%b S=%b R=%b | Q=%b Qnot=%b",
                  $time, Clk, S, R, Q, Qnot);
    end

endmodule
