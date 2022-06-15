const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("SBT", function () {
  let sbt;
  let accounts;
  before(async () => {
    accounts = await hre.ethers.getSigners();
    const SBT = await ethers.getContractFactory("SBT");
    sbt = await SBT.deploy();
    await sbt.deployed();
  });
  it("Mint: Should be able to mint", async function () {
    expect(await sbt.isTokenHolderMap(accounts[0].address)).to.equal(false);
    const mint = await sbt.mint(accounts[0].address, 0);
    await mint.wait();
    expect(await sbt.isTokenHolderMap(accounts[0].address)).to.equal(true);
  });
  it("Mint: Should not be able to mint again", async function () {
    await expect(sbt.mint(accounts[0].address, 0)).to.be.revertedWith(
      "You already own this token"
    );
    await expect(sbt.mint(accounts[0].address, 1)).to.be.revertedWith(
      "You already own this token"
    );
  });
  it("Mint: Should not be able to transfer", async function () {
    await expect(
      sbt.safeTransferFrom(accounts[0].address, accounts[1].address, 0, 1, [])
    ).to.be.revertedWith("Token is not transferable");
  });
});
