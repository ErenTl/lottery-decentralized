from brownie import network, accounts, config, MockV3Aggregator

LOCAL_BLOCKCHAIN_ENVIRONMENTS = [
    "development",
    "ganache-local",
    "ganache-cli",
]  # depends on your brownie env


def get_account():
    if network.show_active() in LOCAL_BLOCKCHAIN_ENVIRONMENTS:
        return accounts[0]
    else:
        return accounts.add(config["wallets"]["from_key"])  # from brownie-config.yaml


def deploy_mock():
    print(f"The active network: {network.show_active()}")
    print("Mock is deploying...")
    if len(MockV3Aggregator) <= 0:
        MockV3Aggregator.deploy(
            config["networks"][network.show_active()]["eth_usd_price_decimals"],
            config["networks"][network.show_active()]["starting_price"],
            {"from": get_account()},
        )
    print("Mock deployed")
