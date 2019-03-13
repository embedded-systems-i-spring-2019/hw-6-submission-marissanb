----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/12/2019 11:02:10 AM
-- Design Name: 
-- Module Name: P4 - FSM
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity P4 is
  Port (
        X1, X2: in std_logic;
        CLK: in std_logic;
        INIT: in std_logic;
        Z1, Z2: out std_logic
   );
end P4;

architecture FSM of P4 is
type state is (a,b,c);
signal PS, NS: state;

begin
    sync_process: process(CLK,NS,INIT)
    begin
        if INIT = '1' then
            PS <= a;
        elsif rising_edge(CLK) then
            PS <= NS;
        end if;
    end process sync_process;
    
    comb_process: process(PS,X1,X2)
    begin
    -- preassign outputs
    Z1 <= '0';
    Z2 <= '0';
    case PS is
        when a =>
            Z1<= '0';
            if X1 = '0' then
                Z2 <= '0';
                NS <= c;
            else
                Z2 <= '1';
                NS <= b;
            end if;
        when b =>
            Z1 <= '1';
            if X2 = '0' then
                Z2 <= '1';
                NS <= c;
            else
                Z2 <= '0';
                NS <= a;
            end if;
        when c =>
            Z1 <= '1';
            if X1 = '0' then
                Z2 <= '1';
                NS <= a;
            else
                Z2 <= '1';
                NS <= b;
            end if;
        when others =>
            Z1 <= '0';
            Z2 <= '0';
            NS <= a;
        end case;
    end process comb_process;
            

end FSM;
