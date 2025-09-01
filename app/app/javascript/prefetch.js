let prefetchDisabledMessage = false;

document.addEventListener("turbo:before-prefetch", (event) => {
  if (isSavingData() || hasSlowInternet()) {
    event.preventDefault()

    if (!prefetchDisabledMessage) {
      console.log("Prefetch is disabled to save data");
      prefetchDisabledMessage = true;
    }
  }
})

function isSavingData() {
  return navigator.connection?.saveData
}

function hasSlowInternet() {
  return navigator.connection?.effectiveType === "slow-2g" ||
    navigator.connection?.effectiveType === "2g" ||
    navigator.connection?.effectiveType === "3g"
}
