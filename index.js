/**
 * This file is taken from https://github.com/HeinrichApfelmus/threepenny-gui/blob/master/doc/electron.md
 */

const argv = process.argv

if (argv.length < 3) {
  console.log("The threepenny executable file-path is required as an argument.")
} else {
  const { app, BrowserWindow } = require('electron');
  const freeport = require('freeport');
  const spawn = require('child_process').spawn;
  const path = require('path');
  const waitOn = require('wait-on');

  const timeout = 10000;
  const relBin = argv[2];

  freeport((err, port) => {
    if (err) throw err;

    const url = `http://localhost:${port}`;
    let child = null;
    let win;

    function createWindow() {
      win = new BrowserWindow({
        width: 800,
        height: 600,
        webPreferences: { nodeIntegration: true },
      });

      console.log(`Loading URL: ${url}`);
      win.loadURL(url);

      win.on('closed', () => {
        win = null;
      });
    }

    app.on('ready', () => {
      child = spawn(path.join(__dirname, relBin), [port]);
      child.stdout.setEncoding('utf8');
      child.stderr.setEncoding('utf8');
      child.stdout.on('data', console.log);
      child.stderr.on('data', console.log);
      child.on('close', code =>
        console.log(`Threepenny app exited with code ${code}`));

      waitOn({ resources: [url], timeout }, (err_) => {
        if (err_) throw err_;
        createWindow();
      });
    });

    app.on('window-all-closed', () => {
      if (process.platform !== 'darwin') {
        app.quit();
      }
    });

    app.on('will-quit', () => child.kill());

    app.on('activate', () => {
      if (win === null) {
        createWindow();
      }
    });
  });
}
