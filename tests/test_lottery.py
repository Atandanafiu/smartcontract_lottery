# 0.17
# 17000000000000000000

from brownie import Lottery, accounts, config, network, web3
from web3 import Web3


def test_get_entrance_fee():
    account = accounts[0]
    lottery = Lottery.deploy(
        config["networks"][network.show_active()]["eth_usd_price_feed"], {"from": account})
    # 16000000000000000000
    assert lottery.getEntranceFee() > web3.toWei(0.016, "ether")
    assert lottery.getEntranceFee() < web3.toWei(0.020, "ether")
