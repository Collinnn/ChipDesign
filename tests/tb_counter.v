`timescale 1ns/1ps
`define assert(signal, value) \
        if (signal !== value) begin \
            $display("ASSERTION FAILED in %m: signal != value"); \
            $display("Expected: %b", value); \
            $display("Received: %b", signal); \
            $finish; \
        end
module up_down_counter_tb;
    // Testbench Signals
    reg clk;
    reg reset;
    reg enable;
    reg set;
    reg up_down;
    reg [3:0] set_value;
    wire [3:0] count;

    // Instantiate the DUT (Device Under Test)
    up_down_counter dut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .set(set),
        .set_value(set_value),
        .up_down(up_down),
        .count(count)
    );
    //Clock Generation
    always #5 clk = ~clk;
    initial begin
        clk = 0;
        reset = 0;
        enable = 0;
        set = 0;
        up_down = 1;
        set_value = 4'b0000;
        // Test 1
        #40 reset = 1;
        #40 reset = 0;
        enable = 1;
        set = 1;
        set_value = 4'b1010;
        #40 set = 0;
        
        enable = 0;
        #40 enable = 1; //NOthing is happening
        up_down = 0;
        #40 up_down = 1;
        enable = 0; //Should return to same value

        set_value = 4'b0000;
        set = 1;
        #40 set = 0;
        enable = 1;
        #40 enable = 0;
        $finish;
    end
    //always @(posedge clk) begin
    //    `assert(reset,0);
    //end
    
    // Monitor Output
    initial begin
        $monitor("Time = %0t | Reset = %b | Set = %b | Set Value = %b | Enable = %b | Up_Down = %b | Count = %b", 
                 $time, reset, set, set_value, enable, up_down, count);
    end
    
endmodule