`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:08:53 07/15/2026 
// Design Name: 
// Module Name:    Traffic_Light_Controller_With_Pedestrian_Crossing 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Traffic_Light_Controller_With_Pedestrian_Crossing(
    input clk,
    input reset,
    input ped_request,
    output reg[2:0]road,
    output reg[1:0]pedestrian
    );
parameter RED    = 3'b100;
parameter YELLOW = 3'b010;
parameter GREEN  = 3'b001;

parameter STOP = 2'b10;
parameter WALK = 2'b01;

parameter S0 = 2'b00; 
parameter S1 = 2'b01; 
parameter S2 = 2'b10; 
parameter S3 = 2'b11;

reg [1:0] state, next_state;


always @(posedge clk or posedge reset)
begin
    if(reset)
        state <= S0;
    else
        state <= next_state;
end


always @(*)
begin
    case(state)
        S0: next_state = S1;
        S1: if(ped_request)
                next_state = S2;
            else
                next_state = S3;
        S2: next_state = S3;
        S3: next_state = S0;
        default: next_state = S0;
    endcase
end


always @(*)
begin
    case(state)
        S0: begin
            road = GREEN;
            pedestrian = STOP;
        end

        S1: begin
            road = YELLOW;
            pedestrian = STOP;
        end

        S2: begin
            road = RED;
            pedestrian = WALK;
        end

        S3: begin
            road = RED;
            pedestrian = STOP;
        end

        default: begin
            road = RED;
            pedestrian = STOP;
        end
    endcase
end

endmodule
