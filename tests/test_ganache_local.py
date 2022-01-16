from scripts.helpful_scripts import (
    get_account,
    deploy_mock,
    LOCAL_BLOCKCHAIN_ENVIRONMENTS,
)
from brownie import network, config, MockV3Aggregator, Lottery


def test_deploy():
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
    print(f"lottery.owner is {lottery.owner()}")
    assert lottery.owner() == account
