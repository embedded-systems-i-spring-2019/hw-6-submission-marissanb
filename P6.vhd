----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/12/2019 11:21:39 AM
-- Design Name: 
-- Module Name: P6 - FSM
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

entity P6 is
  Port (
        X: in std_logic;
        CLK: in std_logic;
        Z1,Z2: out std_logic;
        Y: out std_logic_vector(1 downto 0)
   );
end P6;

architecture FSM of P6 is
type state is (ST0, ST1, ST2, ST3);
attribute ENCODING: STRING;
attribute ENCODING of state: type is "00 01 11 10";
signal PS,NS: state;

begin
    sync_process: process (CLK, NS)
    begin
        if rising_edge(CLK) then
            PS <= NS;
        end if;
    end process sync_process;
    
    comb_process: process (PS, X)
    begin
    -- pre-assign outputs
    Z1 <= '0';
    Z2 <= '0';
    Y <= (others => '0');
    case PS is
        when ST0 =>
            Z1 <= '1';
            if X = '0' then
                Z2 <= '0';
                NS <= ST3;
            else
                Z2 <= '0';
                NS <= ST0;
            end if;
        when ST1 =>
            Z1 <= '0';
            if X = '0' then
                Z2 <= '0';
                NS <= ST2;
            else
                Z2 <= '0';
                NS <= ST1;
            end if;
        when ST2 =>
            Z1 <= '0';
            if X = '0' then
                Z2 <= '1';
                NS <= ST0;
            else
                Z2<= '0';
                NS <= ST1;
            end if;
        when ST3 =>
            Z1 <= '1';
            if X = '0' then
                Z2 <= '0';
                NS <= ST1;
            else
                Z2 <= '0';
                NS <= ST0;
            end if;
        when others=>
            Z2 <= '0';
            NS <= ST0;
        end case;
    end process comb_process;
    
--one-hot encoding
with PS select
    Y <=    "00" when ST0,
            "01" when ST1,
            "11" when ST2,
            "10" when ST3,
            "00" when others;
            
end FSM;
