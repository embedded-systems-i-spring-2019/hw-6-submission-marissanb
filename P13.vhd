----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/12/2019 11:44:15 AM
-- Design Name: 
-- Module Name: P13 - FSM
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

entity P13 is
  Port (
        X1, X2: in std_logic;
        CLK: in std_logic;
        CS, RD: out std_logic;
        Y: out std_logic_vector(2 downto 0)
   );
end P13;

architecture FSM of P13 is
type state is (a,b,c);
attribute encoding: string;
attribute encoding of state: type is ("001 010 100");
signal PS,NS: state;

begin
    sync_process: process(CLK,NS)
    begin
        if rising_edge(CLK) then
            PS <= NS;
        end if;
    end process sync_process;
    
    comb_process: process(PS,X1,X2)
    begin
    -- pre-assign outputs
    CS <= '0';
    RD <= '0';
    Y <= (others => '0');
    case PS is
        when a =>
            if X1 = '0' then
                CS <= '0';
                RD <= '1';
                NS <= b;
            else
                CS <= '1';
                RD <= '0';
                NS <= c;
            end if;
        when b =>
            CS <= '1';
            RD <= '1';
            NS <= c;
        when c =>
            if X2 = '0' then
                CS <= '0';
                RD <= '0';
                NS <= a;
            else
                CS <= '0';
                RD <= '1';
                NS <= c;
           end if;
        when others =>
            CS <= '0';
            RD <= '0';
            NS <= a;
        end case;
    end process comb_process;
    
with PS select
    Y <= "001" when a,
        "010" when b,
        "100" when c,
        "001" when others;    
            

end FSM;
