from brownie import Lottery, config, network, MockV3Aggregator

from scripts.helpful_scripts import (
    get_account,
    LOCAL_BLOCKCHAIN_ENVIRONMENTS,
    deploy_mock,
)


def main():
    deploy_lottery()


def deploy_lottery():
    account = get_account()

    if network.show_active() not in LOCAL_BLOCKCHAIN_ENVIRONMENTS:
        price_feed_address = config["networks"][network.show_active()][
            "eth_usd_price_feed"
        ]
    else:
        deploy_mock()
        price_feed_address = MockV3Aggregator[-1].address

    lottery = Lottery.deploy(
        price_feed_address,
        config["networks"][network.show_active()]["eth_usd_price_decimals"],
        config["networks"][network.show_active()]["fee"],
        {"from": account},
    )

    
