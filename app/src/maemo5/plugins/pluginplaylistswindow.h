/*
 * Copyright (C) 2015 Stuart Howarth <showarth@marxoft.co.uk>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 3 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef PLUGINPLAYLISTSWINDOW_H
#define PLUGINPLAYLISTSWINDOW_H

#include "stackedwindow.h"
#include "pluginplaylistmodel.h"

class ImageCache;
class NowPlayingAction;
class ListView;
class QLabel;
class QVBoxLayout;

class PluginPlaylistsWindow : public StackedWindow
{
    Q_OBJECT
    
public:
    explicit PluginPlaylistsWindow(StackedWindow *parent = 0);
    ~PluginPlaylistsWindow();

public Q_SLOTS:
    void list(const QString &service, const QString &id = QString());
    void search(const QString &service, const QString &query, const QString &order);
    
private Q_SLOTS:
    void showPlaylist(const QModelIndex &index);
    
    void onImageReady();
    void onModelStatusChanged(ResourcesRequest::Status status);
    
private:
    PluginPlaylistModel *m_model;
    ImageCache *m_cache;
    
    NowPlayingAction *m_nowPlayingAction;
    ListView *m_view;
    QAction *m_reloadAction;
    QLabel *m_label;
    QVBoxLayout *m_layout;
};
    
#endif // PLUGINPLAYLISTSWINDOW_H
