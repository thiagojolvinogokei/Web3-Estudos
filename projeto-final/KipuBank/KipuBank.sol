// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract KipuBank {
    // Variável imutável para o limite máximo do banco (capacidade do banco)
    uint256 public immutable s_bank;
    
    // Constante para o valor máximo de saque por transação
    uint256 public constant MAX_WITHDRAWAL = 1 ether;
    
    // Mapeamento para armazenar os saldos dos usuários
    mapping(address => uint256) private balances;

    // Eventos para ações de depósito e saque
    event Deposit(address user, uint256 amount);
    event Withdrawal(address user, uint256 amount);

    // Construtor para definir o valor inicial do s_bank
    // @param _bankCap O valor máximo do banco a ser definido no contrato
    constructor(uint256 _bankCap) {
        require(_bankCap > 0, "Bank cap must be greater than zero");
        s_bank = _bankCap;
    }

    // Modifier para verificar se o depósito respeita o limite do banco
    // @param _amount O valor a ser depositado
    modifier checkBankCap(uint256 _amount) {
        require(
            address(this).balance + _amount <= s_bank,
            "Deposit exceeds bank cap"
        );
        _; // Executa o corpo da função modificada
    }

    // Modifier para validar as condições de saque
    // @param _amount O valor que o usuário deseja sacar
    modifier validateWithdrawal(uint256 _amount) {
        require(_amount <= balances[msg.sender], "Insufficient balance");
        require(_amount <= MAX_WITHDRAWAL, "Withdrawal exceeds maximum limit");
        _; // Executa o corpo da função modificada
    }

    // Função para depositar ETH dentro do contrato
    // @dev Recebe um valor em ETH e o adiciona ao saldo do usuário, se respeitar o limite do banco
    function deposit() external payable checkBankCap(msg.value) {
        require(msg.value > 0, "Deposit amount must be greater than zero");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    // Função para sacar ETH do contrato
    // @param _amount O valor que o usuário deseja sacar
    // @dev Reduz o saldo do usuário e transfere o ETH para ele, se todas as condições forem validadas
    function withdraw(uint256 _amount) external validateWithdrawal(_amount) {
        balances[msg.sender] -= _amount;
        (bool success, ) = msg.sender.call{value: _amount}("");
        require(success, "ETH transfer failed");
        emit Withdrawal(msg.sender, _amount);
    }

    // Função para obter o saldo de um usuário específico
    // @param _user O endereço do usuário
    // @return O saldo em ETH do usuário
    function getBalance(address _user) external view returns (uint256) {
        return balances[_user];
    }

    // Função para obter o saldo total de ETH no contrato
    // @return O saldo total de ETH armazenado no contrato
    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
