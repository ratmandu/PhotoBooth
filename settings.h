/*
  Copyright (C) 2014 - Justin Richards

  This file is part of Photobooth.

  Photobooth is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  Photobooth is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with Photobooth.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>
#include <QSettings>

// This entire class is pretty self-explanatory.
// QML does not currently have a QML->QSettings class
// so this adds one for ease of use and convenience

// The reason for the different types is that QML on
// android does not always work properly with QVariants
class Settings : public QObject
{
  Q_OBJECT
public:
  explicit Settings(QObject *parent = 0);
  ~Settings();

  Q_INVOKABLE void setValue(const QString &key, const QVariant &value);
  Q_INVOKABLE QVariant getValue(const QString &key, const QVariant &defaultValue = QVariant()) const;
  Q_INVOKABLE void setString(const QString &key, const QString &value);
  Q_INVOKABLE QString getString(const QString &key, const QString &defaultValue) const;
  Q_INVOKABLE void setBool(const QString &key, const bool &value);
  Q_INVOKABLE bool getBool(const QString &key, const bool &defaultValue = false) const;
  Q_INVOKABLE void setInt(const QString &key, const int &value);
  Q_INVOKABLE int getInt(const QString &key, const int &defaultValue = 0) const;

private:
  QSettings *m_settings;

signals:

public slots:

};

#endif // SETTINGS_H
