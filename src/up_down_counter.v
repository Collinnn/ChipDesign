module up_down_counter (
    input wire clk,
    input wire reset,
    input wire enable,
    input wire set,
    input wire [3:0] set_value,
    input wire up_down, // 1 for up, 0 for down
    output reg [3:0] count
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'b0000;
        end else if (enable) begin
            if (set) begin
                count <= set_value;
            end else if (up_down) begin
                count <= count + 1;
            end else begin
                count <= count - 1;
            end
        end
    end
endmodule