module sumador8bits (
     input wire clk,
     input wire rst,
     input wire enable,
     output reg [7:0] out,
     output reg cout
) ;

    always@ (posedge clk or negedge rst) begin
       if (!rst)
       begin
             out = 8'd0;
            cout = 1'b0;
       end
       else if (enable)
            {cout, out} = {cout, out} + 9'd1;
    end
endmodule