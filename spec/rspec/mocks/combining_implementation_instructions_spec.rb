require 'spec_helper'

module RSpec
  module Mocks
    describe "Combining implementation instructions" do
      it 'can combine and_yield and and_return' do
        dbl = double
        dbl.stub(:foo).and_yield(5).and_return(3)

        expect { |b|
          expect(dbl.foo(&b)).to eq(3)
        }.to yield_with_args(5)
      end

      it 'can combine and_yield, a block implementation and and_return when passing a block to `stub`' do
        dbl = double
        block_called = false
        dbl.stub(:foo) { block_called = true }.and_yield(5).and_return(3)

        expect { |b|
          expect(dbl.foo(&b)).to eq(3)
        }.to yield_with_args(5)

        expect(block_called).to be_true
      end

      it 'can combine and_yield, a block implementation and and_return when passing a block to `with`' do
        dbl = double
        block_called = false
        dbl.stub(:foo).with(:arg) { block_called = true }.and_yield(5).and_return(3)

        expect { |b|
          expect(dbl.foo(:arg, &b)).to eq(3)
        }.to yield_with_args(5)

        expect(block_called).to be_true
      end

      it 'can combine and_yield and and_raise' do
        dbl = double
        dbl.stub(:foo).and_yield(5).and_raise("boom")

        expect { |b|
          expect {
            dbl.foo(&b)
          }.to raise_error("boom")
        }.to yield_with_args(5)
      end

      it 'can combine and_yield, a block implementation and and_raise' do
        dbl = double
        block_called = false
        dbl.stub(:foo) { block_called = true }.and_yield(5).and_raise("boom")

        expect { |b|
          expect {
            dbl.foo(&b)
          }.to raise_error("boom")
        }.to yield_with_args(5)

        expect(block_called).to be_true
      end

      it 'can combine and_yield and and_throw' do
        dbl = double
        dbl.stub(:foo).and_yield(5).and_throw(:bar)

        expect { |b|
          expect {
            dbl.foo(&b)
          }.to throw_symbol(:bar)
        }.to yield_with_args(5)
      end

      it 'can combine and_yield, a block implementation and and_throw' do
        dbl = double
        block_called = false
        dbl.stub(:foo) { block_called = true }.and_yield(5).and_throw(:bar)

        expect { |b|
          expect {
            dbl.foo(&b)
          }.to throw_symbol(:bar)
        }.to yield_with_args(5)

        expect(block_called).to be_true
      end
    end
  end
end

