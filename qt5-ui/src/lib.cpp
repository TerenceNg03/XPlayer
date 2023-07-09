#include "mainwindow.hpp"
#include <QApplication>
#include <QMediaPlayer>
#include <QMediaPlaylist>
#include <QVideoWidget>
#include <QFileDialog>
#include "lib.hpp"

int runGUI(int port) {
  int argc = 0;
  char **argv = NULL;
  QApplication app(argc, argv);

  // Retina display support for Mac OS, iOS and X11:
  // http://blog.qt.io/blog/2013/04/25/retina-display-support-for-mac-os-ios-and-x11/
  //
  // AA_UseHighDpiPixmaps attribute is off by default in Qt 5.1 but will most
  // likely be on by default in a future release of Qt.
  app.setAttribute(Qt::AA_UseHighDpiPixmaps);

  QIcon appIcon;
  appIcon.addFile(":/icons/icon-128");
  app.setWindowIcon(appIcon);

  MainWindow mainWindow;

  auto player = new QMediaPlayer;

  auto playlist = new QMediaPlaylist(player);

  auto url = QFileDialog::getOpenFileUrl();
  playlist->addMedia(url);

  auto videoWidget = new QVideoWidget;
  player->setVideoOutput(videoWidget);

  mainWindow.setCentralWidget(videoWidget);

  mainWindow.show();
  player->setPlaylist(playlist);
  playlist->setCurrentIndex(1);
  player->play();
  return app.exec();
}

int main(int argc, char *argv[]) { return runGUI(0); }
