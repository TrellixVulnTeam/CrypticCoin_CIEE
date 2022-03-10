#!/usr/bin/env python3
# Copyright (c) 2019 The Crypticcoin developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or https://www.opensource.org/licenses/mit-license.php .

from decimal import Decimal
from test_framework.test_framework import BitcoinTestFramework
from test_framework.util import (
    assert_equal,
    get_coinbase_address,
    start_nodes,
    wait_and_assert_operationid_status,
)


class ShorterBlockTimes(BitcoinTestFramework):
    def __init__(self):
        super().__init__()
        self.num_nodes = 4
        self.setup_clean_chain = True

    def setup_nodes(self):
        return start_nodes(self.num_nodes, self.options.tmpdir, [[
            '-nuparams=2bb40e60:106', # Blossom
        ]] * self.num_nodes)

    def run_test(self):
        print("Mining blocks...")
        self.nodes[0].generate(101)
        self.sync_all()

        # Sanity-check the block height
        assert_equal(self.nodes[0].getblockcount(), 101)

        node0_taddr = get_coinbase_address(self.nodes[0])
        node0_zaddr = self.nodes[0].z_getnewaddress('sapling')
        recipients = [{'address': node0_zaddr, 'amount': Decimal('10.0')}]
        myopid = self.nodes[0].z_sendmany(node0_taddr, recipients, 1, 0)
        txid = wait_and_assert_operationid_status(self.nodes[0], myopid)
        assert_equal(105, self.nodes[0].getrawtransaction(txid, 1)['expiryheight'])  # Blossom activation - 1
        self.sync_all()
        self.nodes[0].generate(1)
        self.sync_all()
        assert_equal(10, Decimal(self.nodes[0].z_gettotalbalance()['private']))

        self.nodes[0].generate(2)
        self.sync_all()
        print("Mining last pre-Blossom blocks")
        # Activate blossom
        self.nodes[1].generate(1)
        self.sync_all()
        # Check that we received a pre-Blossom mining reward
        assert_equal(10, Decimal(self.nodes[1].getwalletinfo()['immature_balance']))

        # After blossom activation the block reward will be halved
        print("Mining first Blossom block")
        self.nodes[1].generate(1)
        self.sync_all()
        # Check that we received an additional Blossom mining reward
        assert_equal(15, self.nodes[1].getwalletinfo()['immature_balance'])

        # Send and mine a transaction after activation
        myopid = self.nodes[0].z_sendmany(node0_taddr, recipients, 1, 0)
        txid = wait_and_assert_operationid_status(self.nodes[0], myopid)
        assert_equal(147, self.nodes[0].getrawtransaction(txid, 1)['expiryheight'])  # height + 1 + 40
        self.sync_all() # Ensure the transaction has propagated to node 1
        self.nodes[1].generate(1)
        self.sync_all()
        assert_equal(20, Decimal(self.nodes[0].z_gettotalbalance()['private']))


if __name__ == '__main__':
    ShorterBlockTimes().main()
