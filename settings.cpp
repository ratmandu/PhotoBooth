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

#include "settings.h"

Settings::Settings(QObject *parent) :
  QObject(parent)
{
  m_settings = new QSettings();
}

Settings::~Settings()
{
  m_settings->deleteLater();
}

void Settings::setValue(const QString &key, const QVariant &value)
{
  m_settings->setValue(key, value);
  m_settings->sync();
}

QVariant Settings::getValue(const QString &key, const QVariant &defaultValue) const
{
  return m_settings->value(key, defaultValue);
}

void Settings::setString(const QString &key, const QString &value)
{
  m_settings->setValue(key, value);
  m_settings->sync();
}

QString Settings::getString(const QString &key, const QString &defaultValue) const
{
  return m_settings->value(key, defaultValue).toString();
}

void Settings::setBool(const QString &key, const bool &value)
{
  m_settings->setValue(key, value);
  m_settings->sync();
}

bool Settings::getBool(const QString &key, const bool &defaultValue) const
{
  return m_settings->value(key, defaultValue).toBool();
}

void Settings::setInt(const QString &key, const int &value)
{
  m_settings->setValue(key, value);
  m_settings->sync();
}

int Settings::getInt(const QString &key, const int &defaultValue) const
{
  return m_settings->value(key, defaultValue).toInt();
}
